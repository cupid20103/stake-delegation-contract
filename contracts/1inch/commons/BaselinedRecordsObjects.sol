pragma solidity ^0.6.9;
pragma experimental ABIEncoderV2;

import { BrToken } from "../../BrToken.sol";


contract BaselinedRecordsObjects {

    struct BaselinedRecord {  /// [Key]: baselinedRecordId
        BrToken brToken;
        address orgAddress;   /// Organization address
        bytes32[] metadataOfBaselinedRecords;  /// [Note]: Many baselined assets can be stored into this property
    }

}
