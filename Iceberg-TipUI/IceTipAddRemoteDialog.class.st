"
I'm a dialog to add remotes to a repository.
"
Class {
	#name : #IceTipAddRemoteDialog,
	#superclass : #IceTipDialog,
	#instVars : [
		'model',
		'nameLabel',
		'urlLabel',
		'urlText',
		'nameText',
		'acceptBlock'
	],
	#category : #'Iceberg-TipUI-View-Repository'
}

{ #category : #layout }
IceTipAddRemoteDialog class >> defaultLayout [

	^ SpBoxLayout newTopToBottom
		  add: (SpBoxLayout newLeftToRight
				   add: #nameLabel width: self labelWidth;
				   add: #nameText;
				   yourself)
		  height: self inputTextHeight;
		  add: (SpBoxLayout newLeftToRight
				   add: #urlLabel width: self labelWidth;
				   add: #urlText;
				   yourself)
		  height: self inputTextHeight;
		  yourself
]

{ #category : #actions }
IceTipAddRemoteDialog >> accept [

	self validate.
	self model 
		addRemoteNamed: self remoteName 
		url: self remoteUrl.
	^ acceptBlock ifNotNil: [ acceptBlock cull: self remoteName ]
]

{ #category : #initialization }
IceTipAddRemoteDialog >> initialExtentForWindow [

	^ (500@(
		self class inputTextHeight * 2
		+ self class buttonHeight 
		+ 50 "Yes, a magic number"
		)) scaledByDisplayScaleFactor
]

{ #category : #initialization }
IceTipAddRemoteDialog >> initializePresenters [

	super initializePresenters.
	nameLabel := self newLabel
		label: 'Remote name';
		yourself.
	nameText := self newTextInput
		placeholder: 'e.g., user-remote';
		autoAccept: true;
		yourself.
	urlLabel := self newLabel
		label: 'Remote URL';
		yourself.
	urlText := self newTextInput
		placeholder: 'e.g., git@github.com:user/project.git';
		autoAccept: true;
		yourself.

]

{ #category : #accessing }
IceTipAddRemoteDialog >> model [

	^ model
]

{ #category : #accessing }
IceTipAddRemoteDialog >> model: anObject [

	model := anObject
]

{ #category : #'accessing - ui' }
IceTipAddRemoteDialog >> nameLabel [

	^ nameLabel
]

{ #category : #'accessing - ui' }
IceTipAddRemoteDialog >> nameText [

	^ nameText
]

{ #category : #events }
IceTipAddRemoteDialog >> onAccept: aBlock [

	acceptBlock := aBlock
]

{ #category : #accessing }
IceTipAddRemoteDialog >> remoteName [

	^ self nameText text trimmed
]

{ #category : #accessing }
IceTipAddRemoteDialog >> remoteUrl [

	^ self urlText text trimmed
]

{ #category : #initialization }
IceTipAddRemoteDialog >> setModelBeforeInitialization: anObject [

	model := anObject
]

{ #category : #initialization }
IceTipAddRemoteDialog >> titleForWindow [

	^ 'Add remote'
]

{ #category : #'accessing - ui' }
IceTipAddRemoteDialog >> urlLabel [

	^ urlLabel
]

{ #category : #'accessing - ui' }
IceTipAddRemoteDialog >> urlText [

	^ urlText
]

{ #category : #actions }
IceTipAddRemoteDialog >> validate [

	self
		assert: self remoteName notEmpty 
		description: 'You need to specify a remote name.'.
	self
		assert: self remoteUrl notEmpty
		description: 'You need to specify a remote url.'

]
