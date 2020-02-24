function KeyFeature = ExtractKeyFeature(KeyDecimal)
    KeyFeature=bitxor(KeyDecimal(1), KeyDecimal(2));
    n=size(KeyDecimal,2);
    for i=3:n
        KeyFeature=bitxor(KeyFeature,KeyDecimal(i));
    end
end

