pragma solidity ^0.6.0;

import { StakeDelegationObjects } from "./StakeDelegationObjects.sol";

contract StakeDelegationStorages is StakeDelegationObjects {

    mapping(address => mapping(uint256 => Checkpoint)) checkpoints;  /// checkpoints
    mapping(address => uint256) checkpointsCounts;                   /// checkpoints count
    mapping(address => address) delegates;                           /// delegatees list

    /// @notice A record of votes checkpoints for each account, by index
    //mapping (address => mapping (uint32 => Checkpoint)) public checkpoints;  /// [Key]: userAddress -> 

    /// @notice The number of checkpoints for each account
    //mapping (address => uint32) public checkpointsCounts;

}
