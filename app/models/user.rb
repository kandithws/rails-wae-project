class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  has_many :win_posts, foreign_key: :winner_id, class_name: "Item", dependent: :nullify
  has_many :comments, dependent: :destroy
  has_many :items, dependent: :destroy
  has_many :bid_items, dependent: :destroy
  has_many :non_bid_items, dependent: :destroy
  has_many :bid_infos, dependent: :destroy
  has_many :report_from_others, as: :reportable, class_name: "Report"
  has_many :reports, dependent: :destroy
  # has_many :images, as: :imageable, dependent: :destroy
  # accepts_nested_attributes_for :images
  has_attached_file :avatar, styles: { :large =>   "500x500>", medium: "300x300>", thumb: "100x100>" },
                    default_url: "/images/missing.png"
  validates_attachment_content_type :avatar, :content_type => %w(image/jpeg image/jpg image/png)

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
         # :omniauthable, omniauth_providers: [:google_oauth2]
  # has_and_belongs_to_many :oauth_credentials
  has_paper_trail
  validates_presence_of :username, :first_name, :last_name, :cell_phone_no, :email, :profession
  validates_uniqueness_of :username, :email
  validates :email, format: { with: /@ait.((asia)|(ac.th))/,
                              message: 'Must be official AIT Emails, i.e. email@ait.asia, or email@ait.ac.th'}

  # https://github.com/zquestz/omniauth-google-oauth2
  # def self.from_omniauth(access_token)
  #   # We will not create the model directly from google,
  #   # We want to keep and manage our own devise session but just use
  #   # Google+ As ait verification platform instead of LDAP
  #   # Therefore just return this data to the google_oauth2 controller
  #   data = access_token.info
  #   puts "*************Return from Oauth*************"
  #   puts access_token.credentials.token
  #   puts Time.at(access_token.credentials.expires_at)
  #   data
  # end

  # ----- Utilities fn -----
  def report_user(reported_user, reason='')

    if reported_user.id != self.id && !reported_user.admin?
      self.reports << Report.new(reportable: reported_user, reason: reason)
      self.save
    else
      false
    end

  end

  def admin?
    self.admin
  end

  def member?
    !self.admin
  end

end
