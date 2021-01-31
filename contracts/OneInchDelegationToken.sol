// SPDX-License-Identifier: agpl-3.0
pragma solidity ^0.6.0;

import { ERC20 } from '@openzeppelin/contracts/token/ERC20/ERC20.sol';
import { StakeDelegation } from './StakeDelegation.sol';
import { OneInch } from "./1inch/1inch-token/OneInch.sol";


/**
 * @notice - The OneInchDelegationToken contract does this and that...
 * @dev - This contract will be deployed
 */
contract OneInchDelegationToken is ERC20, StakeDelegation {

    string NAME = 'OneInch Delegation Token';
    string SYMBOL = '1INCH DELEGATION';
    uint8 DECIMALS = 18;

    constructor(OneInch _oneInch) 
        public 
        ERC20(NAME, SYMBOL) 
        StakeDelegation(_oneInch)
    {
        /// [Todo]: Add somthing to here
    }


    ///-------------------------------------------------------
    /// Main methods of the 1inch delegation token
    ///-------------------------------------------------------
    
    function delegateStaking() public returns (bool) {}
    
    function delegateVoting() public returns (bool) {}
    
    function delegateDistribution() public returns (bool) {}






    ///--------------------------------------------------------
    /// EIP-712 related methods of the 1inch delegation token
    ///--------------------------------------------------------
    

}
