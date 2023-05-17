#conda create -n bf550 python=3.9
#conda activate bf550
conda install -y -c conda-forge mamba
mamba install -y -c conda-forge python=3 ruby=2.7.2 gxx_linux-64 numpy libcairo2
pip install jupyterlab pandas matplotlib drawSvg

gem install bundler

bundle install
