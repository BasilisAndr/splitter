from flask import Flask, jsonify, request, send_file, redirect, url_for, render_template
import subprocess


app = Flask(__name__)


@app.route("/", methods=['POST', 'GET'])
def main_endpoint():
    if request.method == 'POST':
        stri = request.form['input']
        if stri:
            res = subprocess.check_output(f'echo {stri} | hfst-lookup files/rus.hfstol | python files/post.py | python files/postpost.py', shell=True)
            res = res.decode("utf-8")
            wd = res.split('\t')[0]
            a = res.split('\t')[1:]
            return render_template('index.html', wd=wd, a=a)
        return render_template('index.html')
    return render_template('index.html')


if __name__ == "__main__":
    app.run(host='0.0.0.0', debug=True, port=80)


__all__ = app
