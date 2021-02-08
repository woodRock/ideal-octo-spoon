# stock
![flutter](https://github.com/woodRock/ideal-octo-spoon/workflows/Build%20and%20Test/badge.svg)


## Brief

A flutter application to keep track of stock. Use cases include, groceries, bars and stores.

- A basic application to keep track of stock. Applications include groceries, bars, stores. 
- The system will store a history of the items one has bought in the pst. No duplicate items, a user can mark items as `used` (i.e., eaten, sold, withdrawn). Upon writing a stock list they will be prompted to mark whether these `used` items should be replenished
- An item will have a priority, perhaps even a tuple (want/need). Where a user can sort their list by essentials then luxuries.
- Also to provide business value we store an approximated cost value for each product, this may be monetary / time / weight / volume. Where the user sets a desired cost limit, the application an generate an essentials list (low minimum cost) or a luxurious list (maximum cost)

## ACID 

It is is important for the database to be ACID compliant.
- **Atomicity** - Atomicity ensures that each transaction is treateed as a single unit, which either succeeds completely, or fails completely
- **Consistency** - Consistency ensures that a transaction can only bring the database from one valid state to another
- **Isolation** - Transactions are often executed concurrently. Isolation ensures that concurrent execution of transactions leaves the database in the same state that would have bee obtained if the transactions were executed sequentially.
- **Durability** - Durability guarantees that once a transaction has been committed, it will remian commited even in the case of system failure. this usually means that completed transatcions are recored into non-volatile memory.`
