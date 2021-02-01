// SPDX-License-Identifier: agpl-3.0
pragma solidity ^0.6.0;

import { StakeDelegation } from "./StakeDelegation.sol";
import { OneInch } from "./1inch/1inch-token/OneInch.sol";


/**
 * @notice - The OneInchDelegationGovernance contract that control staking, voting, reward destribution
 */
contract StakeDelegationFactory {

    address[] stakeDelegations;

    OneInch public oneInch;  /// 1inch Token

    constructor(OneInch _oneInch) public {
        oneInch = _oneInch;
    }

    function createNewStakeDelegationContract() public returns (bool) {
        StakeDelegation stakeDelegation = new StakeDelegation(oneInch);
        stakeDelegations.push(address(stakeDelegation));
    }

}
