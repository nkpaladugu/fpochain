// SPDX-License-Identifier: GPL-3.0
pragma experimental ABIEncoderV2;
pragma solidity >=0.4.25 <0.9.0;

/**
 * @title Types
 * @author 
 * @dev All the custom types that we have used in FPO Chain
 */
library Types {
    enum UserRole {
        FPO, // 0
        Farmer, // 1
        FPOCustomer, // 2
        Customer // 3
    }

    struct UserDetails {
        UserRole role;
        address id_;
        string name;
        string email;
    }

    enum ProductType {
  
    }

    struct UserHistory {
        address id_; // account Id of the user
        uint256 date; // Added, Purchased date in epoch in UTC timezone
    }

    struct ProductHistory {
        UserHistory manufacturer;
        UserHistory supplier;
        UserHistory vendor;
        UserHistory[] customers;
    }

    struct Product {
        string name;
        string farmerName;
        address fpoaddress;
        uint256 manDateEpoch;
        uint256 expDateEpoch;
        bool isInBatch; // few products will be packed & sold in batches
        uint256 batchCount; // QTY that were packed in single batch
        string barcodeId;
        string productImage;
        ProductType productType;
        string scientificName;
        string usage;
        string[] composition;
    }
}