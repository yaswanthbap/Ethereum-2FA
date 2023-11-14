// https://eth-sepolia.g.alchemy.com/v2/29ZYauhqr1hecI8ROOH2Ajtcc0kqgBaR

require('@nomiclabs/hardhat-waffle');

/** @type import('hardhat/config').HardhatUserConfig */
module.exports = {
  solidity: "0.8.0",
  networks: {
    sepolia:{
      url:'https://eth-sepolia.g.alchemy.com/v2/9mwkGrXdfnByuxRaVgN5Po8QvKoBDoOD',
      accounts:['21e91cd7327619717a8fa78248442a28cdafa88ca28e8034b59a59d676ce30bc']
    }
  }
}