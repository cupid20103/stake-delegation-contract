pragma solidity ^0.6.9;
pragma experimental ABIEncoderV2;

import { BaselinedRecordsStorages } from "./commons/BaselinedRecordsStorages.sol";
import { BaselinedRecordsEvents } from "./commons/BaselinedRecordsEvents.sol";

import { BrToken } from "../BrToken.sol";


/***
 * @title - Tokenization contract
 * @notice - This is the factory contract in order to create BrToken
 **/
contract BaselinedRecords is BaselinedRecordsStorages, BaselinedRecordsEvents {

    uint8 public currentBaselinedRecordId;

    constructor() public {}

    /**
     * @notice - Create a new baselined-record
     */
    function createNewBaselinedRecord(BrToken _brToken, address _orgAddress, bytes32[] memory _metadataOfBaselinedRecords) public returns (bool) {
        uint8 newBaselinedRecordId = getNextBaselinedRecordId();
        currentBaselinedRecordId++;

        /// [Todo]: Add properties for saving a new BaselinedRecord
        BaselinedRecord storage baselinedRecord = baselinedRecords[newBaselinedRecordId];
        baselinedRecord.brToken = _brToken;
        baselinedRecord.orgAddress = _orgAddress;
        baselinedRecord.metadataOfBaselinedRecords = _metadataOfBaselinedRecords;

        emit BaselinedRecordCreated(_brToken, _orgAddress, _metadataOfBaselinedRecords);
    }


    ///------------------------------------------------------------
    /// Private functions
    ///------------------------------------------------------------
    function getNextBaselinedRecordId() private view returns (uint8 nextBaselinedRecordId) {
        return currentBaselinedRecordId + 1;
    }

}
