### Security Potential Issues:

- Attacker can create a shorten link to direct people to phishing websites. We need a function for users to report when detected to prevent and block similar links when required
- Attacker can create a link to force user auto download of malicious software. We can't really know that the link you have doesn't cause a file download (before you call the URL) because even a URL without a file extension can be linked to a file.
    - What you can do is check if the URL contains a file extension, and this can be done using the following code
    - Or create a background job to run in sandbox environment to check every suspicious url and prevent it.
- Validate url format to avoid XSS attack, mailto:, ssh:, slack:, file: link,…
- The capacity of Base62 is larger than Base58, but users can confuse or be fooled by similar links if we allow to customize the link. Zero "0" with capital "O". Capital "I" with lowercase "L". So I decide to use Base58 to avoid that problem.
- Provide preview url before clicking when when embedding the link in another app then they user can know where they will go.
- To avoid DDoS attacks, crawler and bots We can set request limit throttling. Avoid using sequence number ids. The limit is possible at load balances layer (ex: Nginx), application layer (middleware) or even setup a Cloudflare Rate Limiting.