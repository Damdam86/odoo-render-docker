#!/usr/bin/env python3
import http.server
import socketserver
import os

PORT = int(os.environ.get('PORT', 8069))

print(f"🔥 SERVEUR TEST MINIMAL - PORT {PORT}")
print(f"🌐 Interface: 0.0.0.0:{PORT}")

class TestHandler(http.server.SimpleHTTPRequestHandler):
    def do_GET(self):
        self.send_response(200)
        self.send_header('Content-type', 'text/html')
        self.end_headers()
        html = '''
        <html>
        <body>
        <h1>SERVEUR TEST ACTIF</h1>
        <p>Port 8069 fonctionne !</p>
        <p>Odoo CRM sera bientot disponible.</p>
        </body>
        </html>
        '''
        self.wfile.write(html.encode('utf-8'))

with socketserver.TCPServer(("0.0.0.0", PORT), TestHandler) as httpd:
    print(f"✅ SERVEUR EN ÉCOUTE SUR 0.0.0.0:{PORT}")
    try:
        httpd.serve_forever()
    except KeyboardInterrupt:
        print("🛑 Arrêt du serveur")
        httpd.shutdown()