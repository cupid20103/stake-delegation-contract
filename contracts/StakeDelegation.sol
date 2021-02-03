// SPDX-License-Identifier: agpl-3.0
pragma solidity ^0.6.0;

import { SafeMath } from '@openzeppelin/contracts/math/SafeMath.sol';

import { StakeDelegationStorages } from "./stake-delegation/commons/StakeDelegationStorages.sol";
import { StakeDelegationEvents } from "./stake-delegation/commons/StakeDelegationEvents.sol";
import { StakeDelegationConstants } from "./stake-delegation/commons/StakeDelegationConstants.sol";

import { OneInch } from "./1inch/1inch-token/OneInch.sol";
import { GovernanceMothership } from "./1inch/1inch-token-staked/st-1inch/GovernanceMothership.sol";
import { MooniswapFactoryGovernance } from "./1inch/1inch-governance/governance/MooniswapFactoryGovernance.sol";


/**
 * @notice - A liquidity protocol stake delegation contract.
 * @notice - A contract is able to vote on specific parameters in https://1inch.exchange/#/dao/governance for stake and vote delegation and automatic 1inch reward distribution to stakers.
 */
contract StakeDelegation is StakeDelegationStorages, StakeDelegationEvents, StakeDelegationConstants {
    using SafeMath for uint256;

    OneInch public oneInch;                 /// 1INCH Token
    GovernanceMothership public stOneInch;  /// st1INCH token
    MooniswapFactoryGovernance public mooniswapFactoryGovernance;  /// For voting

    address ST_ONEINCH;

    constructor(OneInch _oneInch, GovernanceMothership _stOneInch, MooniswapFactoryGovernance _mooniswapFactoryGovernance) public {
        oneInch = _oneInch;
        stOneInch = _stOneInch;
        mooniswapFactoryGovernance = _mooniswapFactoryGovernance;

        ST_ONEINCH = address(stOneInch);
    }

    ///-------------------------------------------------------
    /// Main methods of the 1inch delegation token
    ///-------------------------------------------------------
    
    function delegateStaking(uint stakeAmount) public returns (bool) {
        oneInch.approve(ST_ONEINCH, stakeAmount);
        stOneInch.stake(stakeAmount);
    }
    
    function delegateVoting(uint vote) public returns (bool) {
        mooniswapFactoryGovernance.defaultFeeVote(vote);
    }
    
    function delegateRewardDistribution() public returns (bool) {}

}
