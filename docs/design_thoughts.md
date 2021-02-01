## Flower Shop Design Thoughts

The goal of the application is to be able to receive customer orders
for flowers and optimise for shipping and overall cost by picking
the smallest number of total bundles.

### Likely Objects

#### Flower
    - attributes: 
        name: string,
        code: string

#### Bundle
    - attributes: 
        size: int,
        price: decimal
        fk_flower_id: int

#### Order
    - attributes:
        number: int,
        code: string

#### BundlePicker
    - arguments:
        number: int
        flower: Flower

#### ShipmentGenerator
    - argument: 
        order: Order


## Processing
1. The `ShipmentGenerator` receives an order
    1. It parses each order item and sends the required number with 
       an array of bundle sizes to the BundlePicker 
1. The `BundlePicker` receives the number and size_array
    1.  The `BundlePicker` generates a potential shipment containing an array
        of bundle_size/number, plus any remainder of flowers unfulfilled by
        the bundles and returns this to the `ShipmentGenerator`
1. The `ShipmentGenerator` receives the proposed shipment and validates it
    1.  It validates the proposed shipment by checking if there is a remainder
    of unfulfilled flowers returned. If so, it invalidates the shipment and requests the
        `BundlePicker` to create a new shipment with different array sizes.
    1. This process is repeated until the `BundlePicker` returns a proposed
    shipment with zero unfulfilled flowers or, the array of potential bundle
       sizes is exhausted.  In this case, the ShipmentGenerator will throw an
       InvalidOrderError.
   1. If a valid shipment is produced, the ShipmentGenerator will print the final
    itemised order and complete.
      

This design was arrived at after consideration of how best to implement to proposed
shipment process. The most obvious solution is to create a recursive function that
iterates through the potential bundle sizes to find the proposed shipment.  Recursive
functions, however, are rarely used in production code as the potential for stack
overflow is great and the speed is usually suboptimal when compared with iterative
solutions.

After deciding an iterative solution is preferable, I settled on the pattern of two
interacting objects, one of which proposes a solution and the other requests and 
validates the solution until the possibilities are exhausted.    


