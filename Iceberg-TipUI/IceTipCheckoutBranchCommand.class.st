"
Command that opens a dialog to checkout a (new or already existing) branch.
"
Class {
	#name : #IceTipCheckoutBranchCommand,
	#superclass : #IceTipRepositoryCommand,
	#category : #'Iceberg-TipUI-Commands'
}

{ #category : #'accessing - defaults' }
IceTipCheckoutBranchCommand class >> defaultDescription [

	^ 'Checkout a new or existing branch.'
]

{ #category : #'accessing - defaults' }
IceTipCheckoutBranchCommand class >> defaultName [

	^ 'Checkout branch'
]

{ #category : #'accessing - defaults' }
IceTipCheckoutBranchCommand class >> defaultToolbarItemName [

	^ 'Branch'
]

{ #category : #testing }
IceTipCheckoutBranchCommand >> canBeExecuted [

	^ super canBeExecuted and: [ self isRepositoryMissing not]
]

{ #category : #executing }
IceTipCheckoutBranchCommand >> execute [

	(IceTipCheckoutBranchDialog on: self repositoryModel)
		openDialog
]

{ #category : #accessing }
IceTipCheckoutBranchCommand >> iconName [

	^ #branch
]
