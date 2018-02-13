import truffleContract from 'truffle-contract'
import truffleExt from 'truffle-ext'
import { web3, web3Provider } from './w3'
import KeyValueStorageJSON from '../../build/contracts/KeyValueStorage.json'

export const KeyValueStorage = getContract(KeyValueStorageJSON)

function getContract (contractAbi) {
  const { requireContract } = truffleExt(web3)
  return requireContract(getTruffleContract(contractAbi))
}

function getTruffleContract (contractAbi) {
  const contract = truffleContract(contractAbi)
  contract.setProvider(web3Provider)
  contract.defaults({
    from: web3.eth.accounts[0],
    gas: 4712388
  })
  return contract
}
