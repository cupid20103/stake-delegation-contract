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
    /// Delegate staking
    ///-------------------------------------------------------
    function delegateStaking(uint stakeAmount) public returns (bool) {
        oneInch.approve(ST_ONEINCH, stakeAmount);
        stOneInch.stake(stakeAmount);
    }


    ///-------------------------------------------------------
    /// Delegate voting
    ///-------------------------------------------------------    
    function delegateFeeVote(uint vote) public returns (bool) {
        mooniswapFactoryGovernance.defaultFeeVote(vote);
    }

    function delegateSlippageFeeVote(uint vote) public returns (bool) {
        mooniswapFactoryGovernance.defaultSlippageFeeVote(vote);
    }

    function delegateDecayPeriodVote(uint vote) public returns (bool) {
        mooniswapFactoryGovernance.defaultDecayPeriodVote(vote);
    }

    function delegateReferralShareVote(uint vote) public returns (bool) {
        mooniswapFactoryGovernance.referralShareVote(vote);
    }

    function delegateGovernanceShareVote(uint vote) public returns (bool) {
        mooniswapFactoryGovernance.governanceShareVote(vote);
    }


    ///-----------------------------------------------------------------
    /// Delegate reward distribution (Claim or UnStake)
    ///-----------------------------------------------------------------

    /**
     * @notice - Delegate reward distribution with Un-Stake
     */
    function delegateRewardDistributionWithUnStake(uint unStakeAmount) public returns (bool) {
        oneInch.approve(ST_ONEINCH, stakeAmount);
        stOneInch.unStake(stakeAmount);        
    }

}
