pragma solidity ^0.6.0;

import { StakeDelegationObjects } from "./StakeDelegationObjects.sol";

abstract contract StakeDelegationStorages is StakeDelegationObjects {

    mapping (address => address[]) delegationAddresses;

}
