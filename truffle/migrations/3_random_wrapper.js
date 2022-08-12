const RandomWrapper = artifacts.require("RandomWrapper");

module.exports = function (deployer) {
  deployer.deploy(RandomWrapper);
};
