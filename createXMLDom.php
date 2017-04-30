<?php
$books = array();
$books [] = array(
	'title' => 'PHP Hacks',
	'author' => 'Jack Herrington',
	'publisher' => "O'Reilly"
);
$books [] = array(
	'title' => 'Podcasting Hacks',
	'author' => 'Jack Herrington',
	'publisher' => "O'Reilly"
);

$doc = new DOMDocument();
$doc->formatOutput = true;

$r = $doc->createElement( "books" );
$doc->appendChild( $r );

foreach( $books as $book )
	{
		$b = $doc->createElement( "book" );

		$author = $doc->createElement( "author" );
		$author->appendChild(
			$doc->createTextNode( $book['author'] )
		);
		$b->appendChild( $author );

		$title = $doc->createElement( "title" );
		$title->appendChild(
			$doc->createTextNode( $book['title'] )
		);
		$b->appendChild( $title );

		$publisher = $doc->createElement( "publisher" );
		$publisher->appendChild(
			$doc->createTextNode( $book['publisher'] )
		);
		$b->appendChild( $publisher );

		$r->appendChild( $b );
	}

echo $doc->saveXML();
?>
