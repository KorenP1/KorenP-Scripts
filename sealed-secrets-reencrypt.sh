kubectl get sealedsecrets -A -o=jsonpath='{range .items[*]}{"\n---\n"}{}{end}' | kubeseal --re-encrypt -o yaml | k apply -f -
