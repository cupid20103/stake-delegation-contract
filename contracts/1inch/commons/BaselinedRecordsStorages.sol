pragma solidity ^0.6.9;
pragma experimental ABIEncoderV2;

import { BaselinedRecordsObjects } from "./BaselinedRecordsObjects.sol";


contract BaselinedRecordsStorages is BaselinedRecordsObjects {

    mapping (uint8 => BaselinedRecord) baselinedRecords;  /// [Key]: baselinedRecordId

}
