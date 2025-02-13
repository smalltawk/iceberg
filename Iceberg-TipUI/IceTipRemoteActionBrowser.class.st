Class {
	#name : #IceTipRemoteActionBrowser,
	#superclass : #IceTipHistoryActionBrowser,
	#instVars : [
		'remotePanel'
	],
	#category : #'Iceberg-TipUI-View-Repository'
}

{ #category : #commands }
IceTipRemoteActionBrowser class >> buildSelectionCommandGroupWith: presenter for: aCommandGroup [

	"No commands to add"
]

{ #category : #layout }
IceTipRemoteActionBrowser class >> defaultLayout [

	^ SpBoxLayout newTopToBottom
		  add: #remotePanel
		  withConstraints: [ :c | c height: self inputTextHeight ];
		  add: #commitsPanel withConstraints: [ :c | c spec: #panelSpec ];
		  add: #actionButtonBar
		  withConstraints: [ :c | c height: self buttonHeight ];
		  yourself
]

{ #category : #'instance creation' }
IceTipRemoteActionBrowser class >> onRepositoryModel: aRepository [
	^ self subclassResponsibility
]

{ #category : #initialization }
IceTipRemoteActionBrowser >> initializePresenters [

	super initializePresenters.
	remotePanel := self
		instantiate: IceTipSelectRemotePresenter
		on: self model.
	remotePanel label: self labelForRemotePanel.
	remotePanel remoteList
		whenSelectedItemChangedDo: [ :remoteModel | self moveToRemote: remoteModel ].

]

{ #category : #initialization }
IceTipRemoteActionBrowser >> initializeWindow: aWindow [

	super initializeWindow: aWindow.
	
	aWindow bindKeyCombination: $s meta toAction: [ self accept ]
]

{ #category : #initialization }
IceTipRemoteActionBrowser >> labelForRemotePanel [

	^ self subclassResponsibility
]

{ #category : #'accessing - ui' }
IceTipRemoteActionBrowser >> mainList [

	^ commitsPanel commitList
]

{ #category : #'accessing - ui' }
IceTipRemoteActionBrowser >> remotePanel [

	^ remotePanel
]

{ #category : #'accessing - ui' }
IceTipRemoteActionBrowser >> remotePanel: aSpPresenter [

	remotePanel := aSpPresenter
]
