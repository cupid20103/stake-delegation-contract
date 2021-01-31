// SPDX-License-Identifier: agpl-3.0
pragma solidity ^0.6.0;

import { ERC20 } from '@openzeppelin/contracts/token/ERC20/ERC20.sol';
import { StakeDelegation } from './StakeDelegation.sol';
import { OneInch } from "./1inch/1inch-token/OneInch.sol";


/**
 * @notice - The OneInchDelegationToken contract does this and that...
 * @dev -  
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
    
}
