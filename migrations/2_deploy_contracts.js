var Msg = artifacts.require("./Msg.sol");
module.exports = function(deployer) {
  deployer.deploy(Msg);
};