// SPDX-License-Identifier: agpl-3.0
pragma solidity ^0.6.0;

import { OneInch } from "./1inch/1inch-token/OneInch.sol";


/**
 * @notice - A liquidity protocol stake delegation contract
 */
contract StakeDelegation {

    mapping (address => address[]) delegationAddresses;

    OneInch public oneInch; /// 1inch Token

    constructor(OneInch _oneInch) public {
        oneInch = _oneInch;
    }

    /**
     * @notice - Register a delegation address
     */ 
    function delegate(address delegationAddress) public returns (bool) {
        /// Add a new token holder address which ask delegation
        delegationAddresses[delegationAddress].push(msg.sender);
    }
    

}
