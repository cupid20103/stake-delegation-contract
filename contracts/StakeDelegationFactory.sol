// SPDX-License-Identifier: agpl-3.0
pragma solidity ^0.6.0;

import { StakeDelegation } from "./StakeDelegation.sol";
import { OneInch } from "./1inch/1inch-token/OneInch.sol";
import { GovernanceMothership } from "./1inch/1inch-token-staked/st-1inch/GovernanceMothership.sol";


/**
 * @notice - The OneInchDelegationGovernance contract that control staking, voting, reward destribution
 */
contract StakeDelegationFactory {

    uint8 currentStakeDelegationId; /// Count from 1
    address[] stakeDelegations;

    event StakeDelegationCreated(
        StakeDelegation stakeDelegation
    );

    OneInch public oneInch;                 /// 1INCH Token
    GovernanceMothership public stOneInch;  /// st1INCH token

    constructor(OneInch _oneInch, GovernanceMothership _stOneInch) public {
        oneInch = _oneInch;
        stOneInch = _stOneInch;
    }

    function createNewStakeDelegation() public returns (bool) {
        currentStakeDelegationId++;
        StakeDelegation stakeDelegation = new StakeDelegation(oneInch, stOneInch);
        stakeDelegations.push(address(stakeDelegation));

        emit StakeDelegationCreated(stakeDelegation);
    }


    ///--------------------------------------------
    /// Getter Methods
    ///--------------------------------------------

    function getStakeDelegations() public view returns (address[] memory _stakeDelegations) {
        return stakeDelegations;
    }

    function getStakeDelegation(uint8 stakeDelegationId) public view returns (address _stakeDelegation) {
        uint8 index = stakeDelegationId - 1;
        return stakeDelegations[index];
    }
    
}
