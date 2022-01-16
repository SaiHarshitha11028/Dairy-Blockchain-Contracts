//importing required modules/libraries
const path = require('path');
const fs = require('fs');
const solc = require('solc')

//building path to our contract file
const contrPath = path.resolve(__dirname, 'contracts', 'Exit.sol');

//reading source code from file
const source = fs.readFileSync(contrPath, 'utf8');

//compiling our source code
const input = {
    language: "Solidity",
    sources: {
        "Exit.sol": {
            content: source,
        },
    },
    settings: {
        outputSelection: {
            "*": {
                "*": ["*"],
            },
        },
    },
};

var output=JSON.parse(solc.compile(JSON.stringify(input)));

const interface = output.contracts['Exit.sol'].Exit.abi;
const bytecode = output.contracts['Exit.sol'].Exit.evm.bytecode.object;

// console.log(interface);
module.exports = {
    interface,
    bytecode,
};