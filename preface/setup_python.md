
# Setup Python
<a id="H_0db1"></a>

## Python packages in MATLAB Online

Some sections of the book require Python packages to complement MATLAB capabilities.


Get pip to install packages in your MATLAB Online session:

```matlab
websave("/tmp/get-pip.py","https://bootstrap.pypa.io/get-pip.py");
!python /tmp/get-pip.py
!python -m pip --version
```

Install requirement with a quiet flag \-q

```matlab
!python -m pip install -q -r requirements.txt
```

Execute Python in a different process. This enables terminating the connection without killing the session

```matlab
pyenv(ExecutionMode="OutOfProcess") 
```
