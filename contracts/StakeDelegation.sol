// SPDX-License-Identifier: agpl-3.0
pragma solidity ^0.6.0;

import { StakeDelegationStorages } from "./stake-delegation/commons/StakeDelegationStorages.sol";
import { StakeDelegationEvents } from "./stake-delegation/commons/StakeDelegationEvents.sol";
import { OneInch } from "./1inch/1inch-token/OneInch.sol";


/**
 * @notice - A liquidity protocol stake delegation contract
 */
contract StakeDelegation is StakeDelegationStorages, StakeDelegationEvents {

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

        (mapping(address => address) storage delegates) = _getDelegationDataByType(delegationType);

        uint256 delegatorBalance = oneInch.balanceOf(delegator);

        address previousDelegatee = _getDelegatee(delegator, delegates);

        delegates[delegator] = delegatee;

        //_moveDelegatesByType(previousDelegatee, delegatee, delegatorBalance, delegationType);
        emit DelegateChanged(delegator, delegatee, delegationType);
    }

    /**
     * @dev returns the delegation data (snapshot, snapshotsCount, list of delegates) by delegation type
     * NOTE: Ideal implementation would have mapped this in a struct by delegation type. Unfortunately,
     * the AAVE token and StakeToken already include a mapping for the snapshots, so we require contracts
     * who inherit from this to provide access to the delegation data by overriding this method.
     * @param delegationType the type of delegation
     */
    function _getDelegationDataByType(DelegationType delegationType) 
        internal 
        virtual 
        view 
        returns (mapping(address => address) storage);

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
    ) external override view returns (uint256) {
        // (
        //   mapping(address => mapping(uint256 => Snapshot)) storage snapshots,
        //   mapping(address => uint256) storage snapshotsCounts,

        // ) = _getDelegationDataByType(delegationType);

        // return _searchByBlockNumber(snapshots, snapshotsCounts, user, blockNumber);
    }



}
