
pragma solidity ^0.8.4;
// SPDX-License-Identifier: MIT

import "@openzeppelin/contracts/token/ERC1155/ERC1155.sol";
import "@openzeppelin/contracts/access/AccessControl.sol";
import "@openzeppelin/contracts/security/Pausable.sol";
import "@openzeppelin/contracts/token/ERC1155/extensions/ERC1155Burnable.sol";
import "@openzeppelin/contracts/token/ERC1155/extensions/ERC1155Supply.sol";


contract FpoAggregatorEcosys is ERC1155, AccessControl, Pausable, ERC1155Burnable, ERC1155Supply {
   
    enum AgriItemStatus {REGISTERED,FUNDED,BOUGHT,DELIVERING_LOCAL,DELIVERING_INTERNATIONAL }
    enum RoleType { FPO,FARMER,CERTIFIFYING_ORG,BANK,INSURER,BUYER}
    //enum ProduceType { RICE,BEANS,WHEAT,REDCHLLIS,A2COWMILK,SPICES}

    bytes32 public constant URI_SETTER_ROLE = keccak256("URI_SETTER_ROLE");
    bytes32 public constant PAUSER_ROLE = keccak256("PAUSER_ROLE");
    bytes32 public constant MINTER_ROLE = keccak256("MINTER_ROLE");

    constructor() ERC1155("") {
        _grantRole(DEFAULT_ADMIN_ROLE, msg.sender);
        _grantRole(URI_SETTER_ROLE, msg.sender);
        _grantRole(PAUSER_ROLE, msg.sender);
        _grantRole(MINTER_ROLE, msg.sender);
    }


    mapping (uint => AgriItem) public agriItems;
    
    
    mapping (uint => RoleEntity) public registeredFPOs;
    mapping (uint => RoleEntity) public registeredBanks;
    mapping (uint => RoleEntity) public registeredInsurers;
    mapping (uint => RoleEntity) public registeredCorpBuyer;

    struct AgriItem {

        address id;
        //ProduceType itemtype;
        string itemtype; // tomato/rice etc
        RoleEntity fpo;
        RoleEntity farmer;
        RoleEntity certificate;
        AgriItemStatus status;
        RoleEntity buyer;
        string quantity;
        string harvestDate;
        string locLatitude;
        string locaLongitude;

    }
    struct RoleEntity {
        address id;
        RoleType role;
        string name;
        
    }
    event NewAgriItemAdded( address indexed itemId , string produceType , string quantity);
    event NewServiceProviderOnboarded( uint indexed spid, address indexed spaddress , string roleType , string name);


    function addAgriItem (address _id, string memory _produceType, uint256  _quantity,string memory _harvestdate, string memory _locLati, 
        string memory _locLongi) public
    {
                uint itemId=0;
               //  itemId= agriItems[msg.sender].length +1;

       // AgriItem memory agriItem = AgriItem(itemId,_id,_produceType, "fpo","farmer","certOrg","status","buyer",_quantity,_harvestdate,_locLati,_locLongi);
        //agriItems.push(itemId,agriItem);
         _mint(_id, 1, _quantity, "some notes");// mint to _id, itemtype-1

       // emit NewAgriItemAdded(itemId, _produceType, _id, _quantity);
        
    }

//  function addProduct(Types.FPOProduct memory product, address myAccount)
//         internal
//     {
//         require(myAccount != address(0));
//         require(users[myAccount].role == Types.UserRole.Fpo, " Either is not FPO or he is not registered");

//         fpoProducts[myAccount] = product; 
// //        emit NewFpoProduct(product);
//     }



        function buyAgriItem (address _id, string memory _produceType, uint256 _quantity) public
    {
                
        super._safeTransferFrom( msg.sender, msg.sender ,1,_quantity,"some notes");
        //emit TransferSingle;
        
    }

    function unmarshalRole (string memory _roletype) private pure returns (RoleEntity memory roleentity) {

        bytes32 encodedMode = keccak256(abi.encodePacked(_roletype));
        bytes32 FPOROLE = keccak256(abi.encodePacked("FPO"));
        bytes32 BUYERROLE = keccak256(abi.encodePacked("BUYER"));
        bytes32 CERTIFIERROLE = keccak256(abi.encodePacked("CERTIFIFYING_ORG"));
        bytes32 BANKROLE = keccak256(abi.encodePacked("BANK"));
        bytes32 INSURERROLE = keccak256(abi.encodePacked("INSURER"));


            // if(encodedMode == FPOROLE) {
            //     return RoleType.FPO;
            // } else if(encodedMode == BUYERROLE) {
            //     return RoleType.BUYER;
            // }

            revert (" invalid role type");
    }

    // function addEcoSysPrividers ( address _id, string memory _roletype, string memory name) public {

    //     RoleType roleType =unmarshalRole(_roletype);
    //     RoleEntity memory serviceProvider = RoleEntity(_id,roleType,name);
       
    //     bytes32 encodedMode = keccak256(abi.encodePacked(_roletype));
    //     bytes32 FPOROLE = keccak256(abi.encodePacked("FPO"));
    //     bytes32 BUYERROLE = keccak256(abi.encodePacked("BUYER"));
   
    //     uint spId=0;

    //         if(serviceProvider.RoleType == FPOROLE) {
    //             spId=registeredFPOs.length+1;
    //             registeredFPOs.push(serviceProvider);
    //         } else if(encodedMode == BUYERROLE) {
    //             spId=registeredCorpBuyer.length+1;
    //             registeredCorpBuyer.push(serviceProvider);
    //         }

    //     emit NewServiceProviderOnboarded(spId,_id,_roletype,name);
    // }
    

    function setURI(string memory newuri) public onlyRole(URI_SETTER_ROLE) {
        _setURI(newuri);
    }

    function pause() public onlyRole(PAUSER_ROLE) {
        _pause();
    }

    function unpause() public onlyRole(PAUSER_ROLE) {
        _unpause();
    }

    function mint(address account, uint256 id, uint256 quantity, bytes memory data)
        public
        onlyRole(MINTER_ROLE)
    {
        _mint(account, id, quantity, data);
    }

    function mintBatch(address to, uint256[] memory ids, uint256[] memory quantity, bytes memory data)
        public
        onlyRole(MINTER_ROLE)
    {
        _mintBatch(to, ids, quantity, data);
    }

    function _beforeTokenTransfer(address operator, address from, address to, uint256[] memory ids, uint256[] memory quantity, bytes memory data)
        internal
        whenNotPaused
        override(ERC1155, ERC1155Supply)
    {
        super._beforeTokenTransfer(operator, from, to, ids, quantity, data);
    }

    // The following functions are overrides required by Solidity.

    function supportsInterface(bytes4 interfaceId)
        public
        view
        override(ERC1155, AccessControl)
        returns (bool)
    {
        return super.supportsInterface(interfaceId);
    }
}
    

