// SPDX-License-Identifier: GPL-3.0
pragma experimental ABIEncoderV2;
pragma solidity ^0.8.17;

/**
 * @title Types
 * @author 
 * @dev All the custom types that we have used in FPO Chain
 */
library Types {
    enum UserRole {
        PlatformOwner, //0
        Fpo, // 1
        CertificaterIssuer, // 2
        Company, // 3
        Bank, // 4
        InsuranceAgency, //5
        InputSupplier //6
    }
    struct UserDetails{
        UserRole role;
        address id_;
        string name;
        string email;
//        string location;
//        int Rating; 
//        int16 NoOfFarmers;
//        mapping(int => string) products; 
    }
    
    // struct FPOAllDetails{
    //     BasicUserDetails BasicDetails;
    //     int16 NoOfFarmers;
    //     mapping(int => string[]) products;             
    // }
//   struct UserDetails {
//         UserRole role;
//         FPODetails FPO
//         address id_;
//         string name;
//         string email;
//     }

    // struct UserDetailedDetials{
    //     UserDetails
    // }

    enum ProductType {
        TOMATO, // 0
        PEPPER, // 1
        RICE, // 2
        WHEAT, // 3
        POTATO // 4
  
    }

    // struct UserHistory {
    //     address id_; // account Id of the user
    //     uint256 date; // Added, Purchased date in epoch in UTC timezone
    // }

    // struct ProductHistory {
    //     UserHistory manufacturer;
    //     UserHistory supplier;
    //     UserHistory vendor;
    //     UserHistory[] customers;
    // }

    struct FPOProduct {
        string name;
        UserDetails FpoDetails;
        ProductType productType;
        string FPOGrade;
        address _id_certificateAuthority;
        string CertificateAutoGrade;
        int32 FpoPricePerUnit;
        string unit;
        string TotalQuantity;
        string AvailableQuantity;
 //       mapping(string => int32) customerNameAndPricequotePerUnit;
    }


}