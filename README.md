# dehydrated-dns-manual

Dehydrated hook for manual DNS verification in Bash.

Manual DNS verification is not recommended, as it cannot be used for automatic certificate renewal. This is a stop-gap hook for manual DNS verification in the event you need to generate a certificate using DNS but don't have an API available.

## Requirements

- dehydrated
- bash (or compatible)

For the purposes of this "documentation", I'm assuming you already have these installed, or know how to install them.

## Usage

- Store the script in a known location. Recommended: /etc/dehydrated/hooks.d/dns-manual/hook.sh
- Run the following dehydrated command:

```bash
dehydrated -c -d example.com [-d www.example.com] -t dns-01 -k /path/to/hook.sh
```

- For each domain you passed, you will have to manually create the TXT records with your DNS provider.
- Dehydrated / LetsEncrypt will verify the TXT records.
- For each domain you passed, you will have to manually remove the TXT records with your DNS provider.
