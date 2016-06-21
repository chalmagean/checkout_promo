# Checkout

I've abstracted out the notion of `product` which means that `Checkout` should
work just fine with any item that responds to `price` and `sku`.

## Usage

See `spec/checkout_spec.rb`.

```
co = Checkout.new(ordered_rules)
co.scan(item)
co.scan(item)
price = co.total
```

## Testing

```
rspec
```
