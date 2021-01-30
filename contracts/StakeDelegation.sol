// SPDX-License-Identifier: agpl-3.0
pragma solidity ^0.6.0;

import { StakeDelegationStorages } from "./stake-delegation/commons/StakeDelegationStorages.sol";
import { StakeDelegationEvents } from "./stake-delegation/commons/StakeDelegationEvents.sol";
import { OneInch } from "./1inch/1inch-token/OneInch.sol";


/**
 * @notice - A liquidity protocol stake delegation contract
 */
contract StakeDelegation is StakeDelegationStorages, StakeDelegationEvents {

    /// @notice A checkpoint for marking number of votes from a given block
    struct Checkpoint {
        uint128 blockNumber;  /// from block.number
        uint128 value;        /// Voting value (Voting Power) 
    }

    // /// @notice A record of votes checkpoints for each account, by index
    // mapping (address => mapping (uint32 => Checkpoint)) public checkpoints;  /// [Key]: userAddress -> 

    // /// @notice The number of checkpoints for each account
    // mapping (address => uint32) public checkpointsCounts;

    OneInch public oneInch; /// 1inch Token

    constructor(OneInch _oneInch) public {
        oneInch = _oneInch;
    }

    /**
     * @notice - Delegates all the powers to a specific user (address of delegatee)
     * @param delegatee the user to which the power will be delegated
     */ 
    function delegate(address delegatee) public returns (bool) {
        /// Add a new token holder address which ask delegation
        delegationAddresses[delegatee].push(msg.sender);

        _delegateByType(msg.sender, delegatee, DelegationType.STAKE);
        _delegateByType(msg.sender, delegatee, DelegationType.VOTING_POWER);
        _delegateByType(msg.sender, delegatee, DelegationType.DISTRIBUTION);
    }
    
    /**
     * @dev delegates the specific power to a delegatee
     * @param delegatee the user which delegated power has changed
     * @param delegationType the type of delegation (VOTING_POWER, PROPOSITION_POWER)
     **/
    function _delegateByType(
        address delegator,
        address delegatee,
        DelegationType delegationType
    ) internal {
        require(delegatee != address(0), 'INVALID_DELEGATEE');

        (, , mapping(address => address) storage delegates) = _getDelegationDataByType(delegationType);

        uint256 delegatorBalance = oneInch.balanceOf(delegator);

        address previousDelegatee = _getDelegatee(delegator, delegates);

        delegates[delegator] = delegatee;

        //_moveDelegatesByType(previousDelegatee, delegatee, delegatorBalance, delegationType);
        emit DelegateChanged(delegator, delegatee, delegationType);
    }

    /**
     * @dev returns the delegation data (checkpoint, checkpointsCount, list of delegates) by delegation type
     * NOTE: Ideal implementation would have mapped this in a struct by delegation type. Unfortunately,
     * the AAVE token and StakeToken already include a mapping for the checkpoints, so we require contracts
     * who inherit from this to provide access to the delegation data by overriding this method.
     * @param delegationType the type of delegation
     */
    function _getDelegationDataByType(DelegationType delegationType) 
        internal 
        virtual 
        view 
        returns (
            mapping(address => mapping(uint256 => Checkpoint)) storage, /// checkpoints
            mapping(address => uint256) storage,                        /// checkpoints count
            mapping(address => address) storage                         /// delegatees list
        );


    /**
     * @dev returns the user delegatee. If a user never performed any delegation,
     * his delegated address will be 0x0. In that case we simply return the user itself
     * @param delegator the address of the user for which return the delegatee
     * @param delegates the array of delegates for a particular type of delegation
     */
    function _getDelegatee(address delegator, mapping(address => address) storage delegates)
        internal
        view
        returns (address)
    {
        address previousDelegatee = delegates[delegator];

        if (previousDelegatee == address(0)) {
          return delegator;
        }

        return previousDelegatee;
    }


    /**
     * @dev returns the delegated power of a user at a certain block
     * @param user the user
     */
    function getPowerAtBlock(
        address user,
        uint256 blockNumber,
        DelegationType delegationType
    ) external view returns (uint256) {
        (
          mapping(address => mapping(uint256 => Checkpoint)) storage checkpoints,
          mapping(address => uint256) storage checkpointsCounts,

        ) = _getDelegationDataByType(delegationType);

        return _searchByBlockNumber(checkpoints, checkpointsCounts, user, blockNumber);
    }

    /**
     * @dev searches a checkpoint by block number. Uses binary search.
     * @param checkpoints the checkpoints mapping
     * @param checkpointsCounts the number of checkpoints
     * @param user the user for which the checkpoint is being searched
     * @param blockNumber the block number being searched
     **/
    function _searchByBlockNumber(
        mapping(address => mapping(uint256 => Checkpoint)) storage checkpoints,
        mapping(address => uint256) storage checkpointsCounts,
        address user,
        uint256 blockNumber
    ) internal view returns (uint256) {
        require(blockNumber <= block.number, 'INVALID_BLOCK_NUMBER');

        uint256 checkpointsCount = checkpointsCounts[user];

        if (checkpointsCount == 0) {
          return oneInch.balanceOf(user);
        }

        // First check most recent balance
        if (checkpoints[user][checkpointsCount - 1].blockNumber <= blockNumber) {
          return checkpoints[user][checkpointsCount - 1].value;
        }

        // Next check implicit zero balance
        if (checkpoints[user][0].blockNumber > blockNumber) {
          return 0;
        }

        uint256 lower = 0;
        uint256 upper = checkpointsCount - 1;
        while (upper > lower) {
              uint256 center = upper - (upper - lower) / 2; // ceil, avoiding overflow
              Checkpoint memory checkpoint = checkpoints[user][center];
              if (checkpoint.blockNumber == blockNumber) {
                return checkpoint.value;
              } else if (checkpoint.blockNumber < blockNumber) {
                lower = center;
              } else {
                upper = center - 1;
              }
        }
        return checkpoints[user][lower].value;
    }



}
