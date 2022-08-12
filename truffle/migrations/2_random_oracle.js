const RandomOracle = artifacts.require("RandomOracle");

module.exports = function (deployer) {
  deployer.deploy(RandomOracle);
};