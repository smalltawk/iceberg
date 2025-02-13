Class {
	#name : #IceTipRemovePackageDialog,
	#superclass : #IceTipDialog,
	#instVars : [
		'model',
		'iconPanel',
		'confirmLabel',
		'removeFromRepositoryCheckbox',
		'unloadFromImageCheckbox'
	],
	#category : #'Iceberg-TipUI-View-WorkingCopy'
}

{ #category : #layout }
IceTipRemovePackageDialog class >> defaultLayout [

	^ SpBoxLayout newTopToBottom
		  add: (SpBoxLayout newLeftToRight
				   add: #iconPanel
				   width: 40 * self currentWorld displayScaleFactor;
				   add: (SpBoxLayout newTopToBottom
						    add: #confirmLabel;
						    add: #unloadFromImageCheckbox height: self inputTextHeight;
						    add: #removeFromRepositoryCheckbox
						    height: self inputTextHeight;
						    yourself);
				   yourself);
		  yourself
]

{ #category : #actions }
IceTipRemovePackageDialog >> accept [

	self removeFromRepositoryCheckbox state
		ifTrue: [ self model remove ].
	self unloadFromImageCheckbox state
		ifTrue: [ self model unload ].
]

{ #category : #'accessing - ui' }
IceTipRemovePackageDialog >> confirmLabel [

	^ confirmLabel
]

{ #category : #accessing }
IceTipRemovePackageDialog >> confirmMessage [

	^ 'Are you sure to remove package {1}?'
]

{ #category : #'accessing - ui' }
IceTipRemovePackageDialog >> iconPanel [

	^ iconPanel
]

{ #category : #initialization }
IceTipRemovePackageDialog >> initialExtentForWindow [

	^ (500
		@ (self class inputTextHeight * 2 + self class buttonHeight + 75))
		scaledByDisplayScaleFactor	"Yes, a magic number"
]

{ #category : #initialization }
IceTipRemovePackageDialog >> initializePresenters [

	super initializePresenters.

	iconPanel := self newImage
		image: (self iconNamed: #question);
		yourself.
	confirmLabel := self newLabel 
		label: (self confirmMessage format: { self model name });
		yourself.
	unloadFromImageCheckbox := self newCheckBox
		label: 'Unload from image';
		state: true;
		yourself.
	removeFromRepositoryCheckbox := self newCheckBox
		label: 'Remove from repository';
		state: true;
		yourself.

]

{ #category : #accessing }
IceTipRemovePackageDialog >> model [

	^ model
]

{ #category : #accessing }
IceTipRemovePackageDialog >> model: anObject [

	model := anObject
]

{ #category : #'accessing - ui' }
IceTipRemovePackageDialog >> removeFromRepositoryCheckbox [

	^ removeFromRepositoryCheckbox
]

{ #category : #initialization }
IceTipRemovePackageDialog >> setModelBeforeInitialization: anObject [

	model := anObject
]

{ #category : #initialization }
IceTipRemovePackageDialog >> titleForWindow [

	^ 'Remove Package'
]

{ #category : #accessing }
IceTipRemovePackageDialog >> unloadFromImageCheckbox [

	^ unloadFromImageCheckbox
]
