// SPDX-License-Identifier: agpl-3.0
pragma solidity ^0.6.0;

import { StakeDelegationStorages } from "./stake-delegation/commons/StakeDelegationStorages.sol";
import { OneInch } from "./1inch/1inch-token/OneInch.sol";


/**
 * @notice - A liquidity protocol stake delegation contract
 */
contract StakeDelegation is StakeDelegationStorages {

    OneInch public oneInch; /// 1inch Token

    constructor(OneInch _oneInch) public {
        oneInch = _oneInch;
    }

    /**
     * @notice - Register a delegation address
     */ 
    function delegate(address delegatee) public returns (bool) {
        /// Add a new token holder address which ask delegation
        delegationAddresses[delegatee].push(msg.sender);
    }
    

}
