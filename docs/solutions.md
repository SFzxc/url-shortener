### Solution

****Capacity Estimation:****

- ****Traffic Computation****

    This will be a read-heavy system, so let's assume a `100:1` read/write ratio with 10 million links generated per month.

    For reads per month:

    *100 ×10 million= 1 billion /month*

    For writes:

    *1×10 million=10 million/month*

    Requests Per Second:

    *(1billion + 10 million) / (30days * 24hrs * 3600s) ~= 389 r/s.*

- ****Storage Computation****

    For storage, we will assume we store each link or record in our database for 5 years. Since we expect around 10M new requests every month, the total number of records we will need to store would be:

    *10M * 12months * 5 years =  600M records*

    If we assume each stored recorded will be approximately 500 bytes. We will need around:

    *600M * 500 bytes = 279.4 Gigabytes*

- ****Shortening Algorithm****

    **Counter Approach**

    In this approach, we will start with a single server which will maintain the count of the keys generated. Once our service receives a request, it can reach out to the counter which returns a unique number and increments the counter. When the next request comes the counter again returns the unique number and this goes on.

    The problem with this approach is that it can quickly become a single point for failure. And if we run multiple instances of the counter we can have collision as it's essentially a distributed system.

    **MD5 Approach**

    The MD5 message-digest algorithm is a widely used hash function producing a 128-bit hash value (or 32 hexadecimal digits). We can use these 32 hexadecimal digits for generating 7 characters long URL. However, this creates a new issue for us, which is duplication and collision.

    **Base62 Approach**

    In this approach, we can encode the original URL using [Base62](https://en.wikipedia.org/wiki/Base62) which consists of the capital letters A-Z, the lower case letters a-z, and the numbers 0-9. So, if we want to generate a URL that is 7 characters long, we will generate 62^7 = ~3.5 trillion different URLs.  However, Zero "0" with capital "O". Capital "I" with lowercase "L". So I decide to use Base58 to avoid that problem.

    **Base58 Approach**

    It is similar to base62 but removes 4 misleading characters. We randomly generate 7 characters long URL and then convert it to bigserial number and use it to represent id.

    Ex: x6RSi4Q (base58) ~= 1786764587433 (base10). We can have max *58^7 = 2,207 billion unique URLs. (adapt enough our current estimation: 600M records)*

    However it still has the possibility of a duplicate although it is quite small, we add retry to make sure it is not duplicated when trying to insert into the database.
