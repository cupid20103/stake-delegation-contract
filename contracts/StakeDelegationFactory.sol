// SPDX-License-Identifier: agpl-3.0
pragma solidity ^0.6.0;

import { StakeDelegation } from "./StakeDelegation.sol";
import { OneInch } from "./1inch/1inch-token/OneInch.sol";


/**
 * @notice - The OneInchDelegationGovernance contract that control staking, voting, reward destribution
 */
contract StakeDelegationFactory {

    uint8 currentStakeDelegationId; /// Count from 1
    address[] stakeDelegations;

    OneInch public oneInch;  /// 1inch Token

    constructor(OneInch _oneInch) public {
        oneInch = _oneInch;
    }

    function createNewStakeDelegation() public returns (bool) {
        currentStakeDelegationId++;
        StakeDelegation stakeDelegation = new StakeDelegation(oneInch);
        stakeDelegations.push(address(stakeDelegation));
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
