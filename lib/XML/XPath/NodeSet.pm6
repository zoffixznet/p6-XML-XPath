use v6.c;

use XML;

class XML::XPath::NodeSet {
    has @.nodes;

    method add(XML::Element $elem) {
        @.nodes.push($elem);
    }

    multi method new(XML::Document $document) {
        my @nodes = ($document.root);
        self.bless(:@nodes);
    }
    multi method new() {
        self.bless();
    }
}
