use v6.c;

use XML::XPath::Evaluable;
use XML::XPath::Number;
use XML::XPath::Types;

class XML::XPath::FunctionCall does XML::XPath::Evaluable {
    has $.function is required;
    has @.args;

    method evaluate(XML::XPath::NodeSet $set, Bool $predicate, Axis $axis = 'self') {
        my $result-of-function;
        given $.function {
            when 'last' {
                $result-of-function = XML::XPath::Number.new(value => $set.nodes.elems);
                return $result-of-function.evaluate($set, $predicate, $axis);
            }
            when 'not' {
                die 'not can use have one parameter' unless @.args.elems == 1;
                my $expression = @.args[0];
                my $interim = $expression.evaluate($set, $predicate, $axis);
                if $interim ~~ XML::XPath::NodeSet {
                    my $result = XML::XPath::NodeSet.new;
                    for $set.nodes -> $node {
                        $result.add($node) unless $interim.contains($node);
                    }
                    return $result;
                } else {
                    X::NYI.new(feature => "funcationcal not for { $interim.WHAT }").throw;
                }
            }
            default {
                X::NYI.new(feature => "functioncall $.function").throw;
            }
        }

    }
}
