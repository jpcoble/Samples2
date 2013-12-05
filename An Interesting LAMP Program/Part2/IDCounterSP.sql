BEGIN
UPDATE NumberToPutInJS
SET Number = (SELECT Count(ID) FROM SuberBeer);
UPDATE NumberToPutInJS
SET SecondsForPHP = (SELECT (Number*75) + 120);
END
