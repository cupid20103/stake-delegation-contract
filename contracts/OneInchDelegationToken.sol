// SPDX-License-Identifier: agpl-3.0
pragma solidity ^0.6.0;

import { ERC20 } from '@openzeppelin/contracts/token/ERC20/ERC20.sol';
//import { GovernancePowerDelegationERC20 } from './GovernancePowerDelegationERC20.sol';  <--Just reference


/**
 * @notice - The OneInchDelegationToken contract does this and that...
 * @dev -  
 */
contract OneInchDelegationToken is ERC20 {

    string NAME = 'OneInch Delegation Token';
    string SYMBOL = '1INCH DELEGATION';
    uint8 DECIMALS = 18;

    constructor() public ERC20(NAME, SYMBOL) {
        /// [Todo]: Add somthing to here
    }
    
}
