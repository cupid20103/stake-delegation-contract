// SPDX-License-Identifier: agpl-3.0
pragma solidity ^0.6.0;

import { SafeMath } from '@openzeppelin/contracts/math/SafeMath.sol';

import { StakeDelegationStorages } from "./stake-delegation/commons/StakeDelegationStorages.sol";
import { StakeDelegationEvents } from "./stake-delegation/commons/StakeDelegationEvents.sol";
import { StakeDelegationConstants } from "./stake-delegation/commons/StakeDelegationConstants.sol";

import { OneInch } from "./1inch/1inch-token/OneInch.sol";


/**
 * @notice - A liquidity protocol stake delegation contract.
 * @notice - A contract is able to vote on specific parameters in https://1inch.exchange/#/dao/governance for stake and vote delegation and automatic 1inch reward distribution to stakers.
 */
contract StakeDelegation is StakeDelegationStorages, StakeDelegationEvents, StakeDelegationConstants {
    using SafeMath for uint256;

    OneInch public oneInch; /// 1inch Token

    constructor(OneInch _oneInch) public {
        oneInch = _oneInch;
    }

    ///-------------------------------------------------------
    /// Main methods of the 1inch delegation token
    ///-------------------------------------------------------
    
    function delegateStaking() public returns (bool) {}
    
    function delegateVoting() public returns (bool) {}
    
    function delegateRewardDistribution() public returns (bool) {}

}
