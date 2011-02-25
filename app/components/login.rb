# coding: utf-8
class Login < Netzke::Base

  js_base_class 'Ext.Window'

  def configuration
    super.merge(
      :title => 'Login window',
      :hidden => false,
      :width => 350, :autoHeight => true,
      :closable => false, :resizable => false,
      :items => [{
        :buttons => [ :login.action ],
        :xtype => :form,
        :frame => true,
        :defaultType => :textfield,
        :monitorValid => true,
        :defaults => { :anchor => '100%', :allowBlank => false },
        :items => [{
          :name => 'username',
          :fieldLabel => 'User'
        },{
          :name => 'password',
          :fieldLabel => 'Password',
          :inputType => :password
        }]
      }]
    )
  end

  action :login, :text => 'Enter', :icon => :accept, :formBind => true
  
  js_method :on_login, <<-JS.l
    function(){
      var form = this.items.first().getForm();
      if (form.isValid()){
        this.login(form.getFieldValues());
      }
    }
  JS

  endpoint :login do |para|
    user = User.find(:first, :conditions => {
      :login => para['username'],
      :password => para['password']
    })
    session[:user_id] = user.id unless user.nil?
    { :get_answer => !user.nil?  }
  end

  js_method :get_answer, <<-JS.l
    function (ret){
      if (ret == false) {
        Ext.Msg.alert('Wrong!','Wrong username or password');
      }else{
        window.location = '/users';
      }
    }
  JS
  end
