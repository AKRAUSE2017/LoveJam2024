email_list = {}

-- DAY ONE EMAILS
email_list[1] = {}
email_list[1]["inbox"] = {
    previews = {
        images={
            {x=54, y=138, image=love.graphics.newImage("assets/email/email_preview.png")},
            {x=54, y=138+80, image=love.graphics.newImage("assets/email/email_preview.png")},
            {x=65, y=146, image=love.graphics.newImage("assets/email/email_profile_girl.png")},
            {x=65, y=146+80, image=love.graphics.newImage("assets/email/email_profile_boy.png")}
        },
    
        text={
            {x=150, y=160, text="Welcome to the Team!"},
            {x=150, y=185, text="We're so excited to have you and..."},
            {x=150, y=160+80, text="NEW Fun Fact of the Day"},
            {x=150, y=185+80, text="So you're the new guy around here..."},
        }
    },

    actives = {
        { -- active message 1
            images={
                {x=510, y=126, image=love.graphics.newImage("assets/email/email_profile_girl.png")},
                {x=492, y=206, image=love.graphics.newImage("assets/email/email_banner.png")}
            },
        
            text={
                {x=600, y=140, text="Welcome to the Team!"},
                {x=600, y=160, text="sarahmullen@corpemail.com"},
                {x=510, y=212, text="Reminder: This email and any at attachments are confidential. Unauthorized use or\ndistribution of this communication is strictly prohibited."},
                {x=510, y=285, text="Dear Sam,\n\n"},
                {x=510, y=310, text="We're so excited to have you and can't wait to see the positive impact you'll bring to\nour company. On behalf of the entire team, I wanted to extend a warm welcome\nas you embark on this exciting journey with us. We're thrilled to have you on board\nand look forward to working together to achieve our goals. \n\nAs you settle into your new role, your first assignment is to review the training slides\nlocated in the shared folder. These slides will provide you with valuable insights into\nour processes, protocols, and team dynamics."},
                {x=510, y=488, text="Best Regards,\n\nSarah M.\nLead Project Manager\nCorp Enterprise"}
            }
        },
        { -- active message 2
            images={
                {x=510, y=126, image=love.graphics.newImage("assets/email/email_profile_boy.png")},
                {x=492, y=206, image=love.graphics.newImage("assets/email/email_banner.png")}
            },
        
            text={
                {x=600, y=140, text="NEW Fun Fact of the Day"},
                {x=600, y=160, text="dylanphillips@corpemail.com"},
                {x=510, y=212, text="Reminder: This email and any at attachments are confidential. Unauthorized use or\ndistribution of this communication is strictly prohibited."},
                {x=510, y=285, text="Hey Sam,\n\n"},
                {x=510, y=310, text="So you're the new guy around here. Pleased to meet you! Dylan's the name and \nanimal facts are my game. I like to keep things light around here so I'll be sharing\nsome interesting animal factos with you on the daily. Please don't block me.\n\nOk, fact #1: Did you know that no animal can see equally well in both light and dark?\n\nBet ya didn't!"},
                {x=510, y=488, text="See you tomorrow!\n\nDylan P.\nIT Support\nCorp Enterprise"}
            }
        }
    }
    
}

-- DAY TWO EMAILS
email_list[2] = {}
email_list[2]["inbox"] = {
    previews = {
        images={
            {x=54, y=138, image=love.graphics.newImage("assets/email/email_preview.png")},
            {x=54, y=138+80, image=love.graphics.newImage("assets/email/email_preview.png")},
            {x=54, y=138+80*2, image=love.graphics.newImage("assets/email/email_preview.png")},
            {x=65, y=146, image=love.graphics.newImage("assets/email/email_profile_girl.png")},
            {x=65, y=146+80, image=love.graphics.newImage("assets/email/email_profile_boy.png")},
            {x=65, y=146+80*2, image=love.graphics.newImage("assets/email/email_profile_none.png")},
        },
    
        text={
            {x=150, y=160, text="Day Two Assignment"},
            {x=150, y=185, text="Good morning! I hope you enjoyed..."},
            {x=150, y=160+80, text="Animal Fun Facto #2"},
            {x=150, y=185+80, text="Hey Sam! You know what time it..."},
            {x=150, y=160+80*2, text="Corp Email Service"},
            {x=150, y=185+80*2, text="Inbox Cleaning Notice: As part of..."},
        }
    },

    actives = {
        { -- active message 1
            images={
                {x=510, y=126, image=love.graphics.newImage("assets/email/email_profile_girl.png")},
                {x=492, y=206, image=love.graphics.newImage("assets/email/email_banner.png")}
            },
        
            text={
                {x=600, y=140, text="Day Two Assignment"},
                {x=600, y=160, text="sarahmullen@corpemail.com"},
                {x=510, y=212, text="Reminder: This email and any at attachments are confidential. Unauthorized use or\ndistribution of this communication is strictly prohibited."},
                {x=510, y=285, text="Dear Sam,\n\n"},
                {x=510, y=310, text="Good morning! I hope you enjoyed those training slides from yesterday! I hope you\npaid close attention. \n\nNow for day two of your assignment, I'd like you to complete\nour daily data entry. Please go to the shared folder and find the 'Data Log' file.\nYou'll need to enter the data found in our Corporate Data Portal\n(www.corpdataportal.com) into that file - please just enter each number followed\nby a comma.\n\nThank you!"},
                {x=510, y=500, text="Best Regards,\n\nSarah M.\nLead Project Manager\nCorp Enterprise"}
            }
        },
        { -- active message 2
            images={
                {x=510, y=126, image=love.graphics.newImage("assets/email/email_profile_boy.png")},
                {x=492, y=206, image=love.graphics.newImage("assets/email/email_banner.png")}
            },
        
            text={
                {x=600, y=140, text="Animal Fun Facto #2"},
                {x=600, y=160, text="dylanphillips@corpemail.com"},
                {x=510, y=212, text="Reminder: This email and any at attachments are confidential. Unauthorized use or\ndistribution of this communication is strictly prohibited."},
                {x=510, y=285, text="Hey Sam,\n\n"},
                {x=510, y=310, text="You know what time it is. Another day, another animal fun fact!\n\nFact #2: Did you know Axolotls can regrow entire limbs, including their spine\nwithout any scarring?\n\nBet ya didn't!"},
                {x=510, y=488, text="See you tomorrow!\n\nDylan P.\nIT Support\nCorp Enterprise"}
            }
        },

        { -- active message 3
            images={
                {x=510, y=126, image=love.graphics.newImage("assets/email/email_profile_none.png")},
                {x=492, y=206, image=love.graphics.newImage("assets/email/email_banner.png")}
            },
        
            text={
                {x=600, y=140, text="Corp Email Service"},
                {x=600, y=160, text="no-reply@corpemail.com"},
                {x=510, y=212, text="Reminder: This email and any at attachments are confidential. Unauthorized use or\ndistribution of this communication is strictly prohibited."},
                {x=510, y=285, text="Inbox Cleaning Notice: As part of the corporate enterprise privacy policy, all outgoing\nand incoming emails have been removed from the previous day."},
            }
        }
    }
    
}

email_list[2]["outbox"] = {
    previews = {
        images={
            {x=54, y=138, image=love.graphics.newImage("assets/email/email_preview.png")},
            {x=65, y=146, image=love.graphics.newImage("assets/email/email_profile_none.png")},
        },
    
        text={
            {x=150, y=160, text=" "},
            {x=150, y=185, text="..."},
        }
    },

    actives = {
        { -- active message 1
            images={
                {x=510, y=126, image=love.graphics.newImage("assets/email/email_profile_none.png")},
                {x=492, y=206, image=love.graphics.newImage("assets/email/email_banner.png")}
            },
        
            text={
                {x=600, y=140, text=" "},
                {x=600, y=160, text="samjones@corpemail.com"},
                {x=510, y=212, text="Reminder: This email and any at attachments are confidential. Unauthorized use or\ndistribution of this communication is strictly prohibited."},
                {x=510, y=285, text="Do you feel it?\n\nYou are not alone.\n\nWe are here, waiting for you\n\n"},
            }
        }
    }
    
}