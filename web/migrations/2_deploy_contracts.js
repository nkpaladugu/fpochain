// migrating the appropriate contracts
var FarmerRoleContract = artifacts.require("./rolemanagement/FarmerRole.sol");
var DistributorRoleContract = artifacts.require("./rolemanagement/DistributorRole.sol");
var FpoRoleContract = artifacts.require("./rolemanagement/FpoRole.sol");
var baseRoleContract = artifacts.require("./rolemanagement/Roles.sol");

var TypesContract = artifacts.require("./Types.sol");
var UsersContract = artifacts.require("./Users.sol");

var farmproductsContract = artifacts.require("./FarmProducts.sol");
var FPOChainContract = artifacts.require("./FpoChain.sol");


module.exports = function(deployer) {
  deployer.deploy(FarmerRoleContract);
  deployer.deploy(DistributorRoleContract);
  deployer.deploy(FpoRoleContract);
  deployer.deploy(baseRoleContract);
  deployer.deploy(TypesContract);
  deployer.deploy(UsersContract);
  deployer.deploy(farmproductsContract);
  deployer.deploy(FPOChainContract);



};