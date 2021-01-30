pragma solidity ^0.6.0;

abstract contract StakeDelegationObjects {

    /**
     * @notice - delegationType the type of delegation (VOTING_POWER, PROPOSITION_POWER)
     */
    enum DelegationType { STAKE, VOTING_POWER, DISTRIBUTION }

}
