const HDWalletProvider = require("@truffle/hdwallet-provider");
const Web3 = require("web3");
const util = require("util");

const { abi, evm } = require("./build/CampaignFactory.json");

provider = new HDWalletProvider("", "");

const web3 = new Web3(provider);

const deploy = async () => {
  const accounts = await web3.eth.getAccounts();

  console.log("Attempting to deploy from account", accounts[0]);

  const result = await new web3.eth.Contract(abi)
    .deploy({ data: "0x" + evm.bytecode.object })
    .send({ gas: "3000000", from: accounts[0] });

  console.log(
    util.inspect(abi, { showHidden: false, depth: null, colors: true })
  );
  console.log("Contract deployed to", result.options.address);
  provider.engine.stop();
};
deploy();
