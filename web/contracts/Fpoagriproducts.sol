// contracts/GameItems.sol
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

import "@openzeppelin/contracts/token/ERC1155/ERC1155.sol";
//import '@openzeppelin/contracts/token/ERC1155/ERC1155Metadata.sol';
//import '@openzeppelin/contracts/token/ERC1155/ERC1155MintBurn.sol';
//import "@openzeppelin-solidity/contracts/ownership/Ownable.sol";


contract FPOProduceTokens is ERC1155  {

    address FPOProduceTokenAddress;
    uint256 private _currentTokenID = 0;

    mapping (uint256 => address) public FPOadmins;
    mapping (uint256 => uint256) public tokenSupply;

  // Contract name

    string public name;
  // Contract symbol
    string public symbol;

modifier creatorOnly(uint256 _id) {
    require(FPOadmins[_id] == msg.sender, "ERC1155Tradable#creatorOnly: ONLY_CREATOR_ALLOWED");
    _;
  }

 modifier ownersOnly(uint256 _id) {
    require(balances[msg.sender][_id] > 0, "ERC1155Tradable#ownersOnly: ONLY_OWNERS_ALLOWED");
    _;
  }

constructor(
    string memory _name,
    string memory _symbol,
    address _proxyRegistryAddress
  ) public {
    name = _name;
    symbol = _symbol;
    FPOProduceTokenAddress = _proxyRegistryAddress;
  }

  function uri(
    uint256 _id
  ) public view returns (string memory) {
    require(_exists(_id), "ERC721Tradable#uri: NONEXISTENT_TOKEN");
    return Strings.strConcat(
      baseMetadataURI,
      Strings.uint2str(_id)
    );
  }

function totalSupply(
    uint256 _id
  ) public view returns (uint256) {
    return tokenSupply[_id];
  }

    function setBaseMetadataURI(
    string memory _newBaseMetadataURI
  ) public onlyOwner {
    _setBaseMetadataURI(_newBaseMetadataURI);
  }

  function create(
    address _initialOwner,
    uint256 _initialSupply,
    string calldata _uri,
    bytes calldata _data
  ) external onlyOwner returns (uint256) {

    uint256 _id = _getNextTokenID();
    _incrementTokenTypeId();
    creators[_id] = msg.sender;

    if (bytes(_uri).length > 0) {
      emit URI(_uri, _id);
    }

    _mint(_initialOwner, _id, _initialSupply, _data);
    tokenSupply[_id] = _initialSupply;
    return _id;
  }
}



