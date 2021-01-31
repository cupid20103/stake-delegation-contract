// SPDX-License-Identifier: agpl-3.0
pragma solidity ^0.6.0;

import { OneInch } from "./1inch/1inch-token/OneInch.sol";
import { OneInchDelegationToken } from "./OneInchDelegationToken.sol";
import { StakeDelegationStorages } from "./stake-delegation/commons/StakeDelegationStorages.sol";
import { StakeDelegationEvents } from "./stake-delegation/commons/StakeDelegationEvents.sol";
import { SafeMath } from '@openzeppelin/contracts/math/SafeMath.sol';


/**
 * @notice - The OneInchDelegationGovernance contract
 */
contract OneInchDelegationGovernance is StakeDelegationStorages, StakeDelegationEvents {
    using SafeMath for uint256;

    OneInch public oneInch;  /// 1inch Token
    OneInchDelegationToken public oneInchDelegationToken;

    constructor(OneInch _oneInch, OneInchDelegationToken _oneInchDelegationToken) public {
        oneInch = _oneInch;
        oneInchDelegationToken = _oneInchDelegationToken;
    }


    ///-------------------------------------------------------
    /// Main methods of the 1inch delegation token
    ///-------------------------------------------------------
    
    function delegateStaking() public returns (bool) {}
    
    function delegateVoting() public returns (bool) {}
    
    function delegateDistribution() public returns (bool) {}


}
