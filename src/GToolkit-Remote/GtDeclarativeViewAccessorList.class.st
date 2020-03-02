Class {
	#name : #GtDeclarativeViewAccessorList,
	#superclass : #Object,
	#instVars : [
		'object',
		'accessors'
	],
	#category : #'GToolkit-Remote-Inspection'
}

{ #category : #'instance creation' }
GtDeclarativeViewAccessorList class >> for: anObject [

	^self new object: anObject
]

{ #category : #accessing }
GtDeclarativeViewAccessorList >> accessorWithSelector: aSymbol [

	^accessors detect: [ :each | each selector = aSymbol ]
]

{ #category : #accessing }
GtDeclarativeViewAccessorList >> accessors [

	^ accessors ifNil: [ accessors := self getAccessors ]
]

{ #category : #enumerating }
GtDeclarativeViewAccessorList >> accessorsCollect: aBlock [

	^self accessors collect: aBlock
]

{ #category : #private }
GtDeclarativeViewAccessorList >> getAccessors [

	^Array streamContents: [ :stream |
		(object gtViewsInContext: nil) do: [ :view |
			view canBeGtDeclarativeView ifTrue: [ 
				stream nextPut: (GtDeclarativeViewAccessorServer new 
					object: object;
					view: view ) ] ] ]
]

{ #category : #inspecting }
GtDeclarativeViewAccessorList >> gtViewAccessorsListFor: aView [
	<gtView>
	accessors ifNil: [ aView empty ].
	^ aView list 
		title: 'View accessors';
		items: [ self accessors ]
]

{ #category : #accessing }
GtDeclarativeViewAccessorList >> object [
	^ object
]

{ #category : #accessing }
GtDeclarativeViewAccessorList >> object: anObject [
	object := anObject
]

{ #category : #printing }
GtDeclarativeViewAccessorList >> printOn: aStream [

	super printOn: aStream.
	aStream
		<< '(';
		print: object;
		<< ')'.
]

{ #category : #'private - accessing' }
GtDeclarativeViewAccessorList >> sentItems [
	"Answer the collection of sent items of the receiver.
	This method is provided to facilitate the export of serialised view definitions by GtRemoteInspectorExporter and is not a general access method."

	^accessors flatCollect: #sentItems
]