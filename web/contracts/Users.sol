// SPDX-License-Identifier: GPL-3.0
pragma experimental ABIEncoderV2;
pragma solidity ^0.8.17;

import "./Types.sol";

/**
 * @title Users
 * @author 
 * @dev 
 */
contract Users {
    //mapping(address => Types.UserDetails) public users;
    mapping(address => Types.UserDetails) internal PlatformOwnerlist;
    mapping(address => Types.UserDetails) internal InsuranceAgencylist;
    mapping(address => Types.UserDetails) internal CAlist;
    mapping(address => Types.UserDetails) internal bankList;
    mapping(address => Types.UserDetails) internal CompanyList;
    mapping(address => Types.UserDetails) internal fpoList;
    mapping(address => Types.FPOProduct) internal fpoProducts;

    event NewUser(string name, string email, Types.UserRole  role);
    event NewFPOUser(string name, string email, Types.UserRole role);
 //   event NewFpoProduct(Types.FPOProduct fpoProduct);

    event LostUser(string name, string email, Types.UserRole role);


    constructor(string memory name_, string memory email_) {
        Types.UserDetails memory mn_ = Types.UserDetails({
            role: Types.UserRole.PlatformOwner,
            id_: msg.sender,
            name: name_,
            email: email_
          
        });
        add(mn_);
    }


    /**
     * @dev To add a particular user to a particular role
     * @param user UserDetails that need to be added
     */
    function add(Types.UserDetails memory user) internal {
        require(user.id_ != address(0));
        require(!has(user.role, user.id_), "Same user with same role exists");
        users[user.id_] = user;
        emit NewUser(user.name, user.email, user.role);
    }

    // /**
    //  * @dev To add a particular user to a current logged-in user's correspondence list
    //  * @param user UserDetails that need to be added
    //  * @param myAccount User address who is trying to add the other user
    //  */
    // function addNewUser(Types.UserDetails memory user, address myAccount)
    //     internal
    // {
    //     require(myAccount != address(0));
    //     require(user.id_ != address(0));

    //     if ( 
    //         (get(myAccount).role == Types.UserRole.PlatformOwner) &&
    //         (user.role == Types.UserRole.PlatformOwner)){
    //         // Only PlatformOwner are allowed to add PlatformOwners
    //         PlatformOwnerlist[user.id_] = user ;
    //         add(user); // To add user to global list
    //     } 
    //     else if ( 
    //         (get(myAccount).role == Types.UserRole.PlatformOwner) &&
    //         (user.role == Types.UserRole.Fpo)){
    //         // Only PlatformOwner are allowed to add FPO
    //         fpoList[user.id_] = user;
    //         add(user); // To add user to global list
    //     }       
    //     else if ( 
    //         (get(myAccount).role == Types.UserRole.PlatformOwner) &&
    //         (user.role == Types.UserRole.CertificaterIssuer)){
    //         // Only PlatformOwner are allowed to add Certificate Issuer
    //         CAlist[user.id_] = user;
    //         add(user); // To add user to global list
    //     }  
    //     else if ( 
    //         (get(myAccount).role == Types.UserRole.PlatformOwner) &&
    //         (user.role == Types.UserRole.Company)){
    //         // Only PlatformOwner are allowed to add comapany
    //         bankList[user.id_]=  user;
    //         add(user); // To add user to global list
    //     }
    //     else if ( 
    //         (get(myAccount).role == Types.UserRole.PlatformOwner) &&
    //         (user.role == Types.UserRole.InsuranceAgency)){
    //         // Only PlatformOwner are allowed to add comapany
    //         InsuranceAgencylist[user.id_]= user;
    //         add(user); // To add user to global list
    //     }
    //     else {
    //         revert("Not valid operation");
    //     }
    // }


   /*
     * @dev To add a particular user to a current logged-in user's correspondence list
     * @param user UserDetails that need to be added
     * @param myAccount User address who is trying to add the other user
     */
    function addNewUser(Types.UserRole role,string memory name_, string memory email_, address myAccount)
        public
    {
        require(myAccount != address(0));
        Types.UserDetails memory newUser;
        newUser.role = role;
        newUser.name = name_;
        newUser.email = email_;
        newUser.id_ = msg.sender;

        if ( 
            (get(myAccount).role == Types.UserRole.PlatformOwner) &&
            (role == Types.UserRole.PlatformOwner)){
            // Only PlatformOwner are allowed to add PlatformOwners
            PlatformOwnerlist[msg.sender] = newUser;
            add(newUser); // To add user to global list
        } 
        else if ( 
            (get(myAccount).role == Types.UserRole.PlatformOwner) &&
            (role == Types.UserRole.Fpo)){
            // Only PlatformOwner are allowed to add FPO
            fpoList[msg.sender] = newUser;
            add(newUser); // To add user to global list
        }       
        else if ( 
            (get(myAccount).role == Types.UserRole.PlatformOwner) &&
            (role == Types.UserRole.CertificaterIssuer)){
            // Only PlatformOwner are allowed to add Certificate Issuer
            CAlist[msg.sender] = newUser;
            add(newUser); // To add user to global list // To add user to global list
        }  
        else if ( 
            (get(myAccount).role == Types.UserRole.PlatformOwner) &&
            (role == Types.UserRole.Company)){
            // Only PlatformOwner are allowed to add comapany
            bankList[msg.sender] = newUser;
            add(newUser); // To add user to global list
        }
        else if ( 
            (get(myAccount).role == Types.UserRole.PlatformOwner) &&
            (role == Types.UserRole.InsuranceAgency)){
            // Only PlatformOwner are allowed to add comapany
            InsuranceAgencylist[msg.sender] = newUser;
            add(newUser); // To add user to global list
        }
        else {
            revert("Not valid operation");
        }
    }




   /*
     * @dev To add a particular user to a current logged-in user's correspondence list
     * @param user UserDetails that need to be added
     * @param myAccount User address who is trying to add the other user
     */
    function addProduct(Types.FPOProduct memory product, address myAccount)
        internal
    {
        require(myAccount != address(0));
        require(users[myAccount].role == Types.UserRole.Fpo, " Either is not FPO or he is not registered");

        fpoProducts[myAccount] = product; 
//        emit NewFpoProduct(product);
    }

    /**
     * @dev To get details of the user
     * @param id_ User Id for whom the details were needed
     * @return user_ Details of the current logged-in User
     */
    function getPartyDetails(address id_)
        internal
        view
        returns (Types.UserDetails memory)
    {
        require(id_ != address(0));
        require(get(id_).id_ != address(0));
        return get(id_);
    }

    /**
     * @dev To get user details based on the address
     * @param account User address that need to be linked to user details
     * @return user_ Details of a registered user
     */
    function get(address account)
        internal
        view
        returns (Types.UserDetails memory)
    {
        require(account != address(0));
        return users[account];
    }

    /**
     * @dev To remove a particular user from a particular role
     * @param role User role for which he/she has to be dismissed for
     * @param account User Address that need to be removed
     */
    function remove(Types.UserRole role, address account) internal {
        require(account != address(0));
        require(has(role, account));
        string memory name_ = users[account].name;
        string memory email_ = users[account].email;
        delete users[account];
        emit LostUser(name_, email_, role);
    }

    // Internal Functions

    /**
     * @dev To check if the party/user exists or not
     * @param account Address of the user/party to be verified
     */
    function isPartyExists(address account) internal view returns (bool) {
        bool existing_;
        if (account == address(0)) return existing_;
        if (users[account].id_ != address(0)) existing_ = true;
        return existing_;
    }

    /**
     * @dev check if an account has this role
     * @param role UserRole that need to be checked
     * @param account Account address that need to be verified
     * @return bool whether the same user with same role exists or not
     */
    function has(Types.UserRole role, address account)
        internal
        view
        returns (bool)
    {
        require(account != address(0));
        return (users[account].id_ != address(0) &&
            users[account].role == role);
    }

}